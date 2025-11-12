# 🚀 WebPortfolio Deployment Guide - FREE Forever

## ✅ Your App is Ready to Deploy!

All configuration files have been created and pushed to GitHub. This guide uses **Supabase (free PostgreSQL - never expires)** + **Render.com (free web hosting)** for a completely free, permanent portfolio hosting solution.

---

## 📋 **Step-by-Step Deployment**

### **Step 1: Create Free Database (Supabase)**

**Why Supabase?** 500 MB PostgreSQL, free forever, no expiration!

1. Go to **[supabase.com](https://supabase.com)**
2. Click **"Start your project"** → Sign in with GitHub
3. Click **"New project"**
4. Configure:
   - **Name:** `webportfolio`
   - **Database Password:** Generate strong password (**SAVE IT!**)
   - **Region:** Choose closest to your location
5. Click **"Create new project"** (takes 2-3 minutes)

**Get Your Connection String:**
1. Go to **Settings** → **Database**
2. Scroll to **Connection string** section
3. Select **URI** tab
4. Copy the connection string (replace `[YOUR-PASSWORD]` with your actual password)

**Format:**
```
postgresql://postgres.xxxxxxxxxxxxx:[YOUR-PASSWORD]@aws-0-us-east-1.pooler.supabase.com:5432/postgres
```

**SAVE THIS** - you'll need it for Render!

---

### **Step 2: Get Your Rails Master Key**

You'll need this for Render to decrypt your credentials.

**Option A:** If you have the file locally:
```bash
cat config/master.key
```

**Option B:** Generate a new one (if missing):
```bash
# On your local machine
rails credentials:edit
# This will create config/master.key
# Copy the content
```

**Save this key** - you'll need it in Step 4!

---

### **Step 3: Sign Up for Render.com**

1. Go to **[render.com](https://render.com)**
2. Click **"Get Started"**
3. Sign up with your **GitHub account** (easiest)
4. Authorize Render to access your GitHub repositories

---

### **Step 4: Create New Web Service**

1. On your Render dashboard, click **"New +"**
2. Select **"Web Service"**
3. Click **"Connect a repository"**
4. Find and select: **`linardsb/WebPortfolio`**
5. Select the branch: **`claude/audit-webportfolio-dependencies-011CV3ZbBCmSVe1JtFJ6HJDU`**
   - (Or create a PR and merge to `master` first, then select `master`)

---

### **Step 5: Configure Your Web Service**

Render should auto-detect your `render.yaml` file. Verify these settings:

**Basic Settings:**
- **Name:** `webportfolio` (or your choice)
- **Runtime:** Ruby
- **Build Command:** `./bin/render-build.sh`
- **Start Command:** `bundle exec puma -C config/puma.rb`
- **Plan:** Free

**Environment Variables** (Add these manually):
Click **"Advanced"** and add:

| Key | Value | Notes |
|-----|-------|-------|
| `DATABASE_URL` | `<supabase-connection-string-from-step-1>` | **REQUIRED** - Your Supabase connection string |
| `RAILS_MASTER_KEY` | `<your-key-from-step-2>` | **CRITICAL** - Get from config/master.key |
| `SECRET_KEY_BASE` | Click "Generate" | Auto-generated |
| `RAILS_ENV` | `production` | Auto-set |
| `RACK_ENV` | `production` | Auto-set |

**Optional - AWS S3 (if using file uploads):**

| Key | Value |
|-----|-------|
| `S3_BUCKET_NAME` | Your S3 bucket name |
| `AWS_ACCESS_KEY_ID` | Your AWS access key |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret |
| `AWS_REGION` | `us-east-1` (or your region) |

---

### **Step 6: Deploy!**

1. Click **"Create Web Service"**
2. Render will start building your app
3. Watch the logs - build takes ~5-10 minutes first time
4. Look for: ✅ **"Build successful"** → ✅ **"Deploy live"**

---

### **Step 7: Run Database Migrations** (First Deploy Only)

After first successful deployment:

1. Go to your web service dashboard
2. Click **"Shell"** tab
3. Run:
```bash
bundle exec rails db:migrate
bundle exec rails db:seed  # If you have seed data
```

Or connect via command line:
```bash
# Get your app URL from Render dashboard
render run bundle exec rails db:migrate
```

---

### **Step 8: Create Your Admin User** (Optional)

If using Devise for admin access:

```bash
# In Render Shell
bundle exec rails console

# Then in Rails console:
User.create!(email: 'your@email.com', password: 'yourpassword', password_confirmation: 'yourpassword')
```

---

## 🎉 **Your Site is Live!**

Your portfolio will be available at:
```
https://webportfolio.onrender.com
```
(Or whatever name you chose)

---

## ⚠️ **Important Free Tier Limitations**

### **Sleep Mode:**
- Free apps sleep after 15 minutes of inactivity
- First visit after sleep takes 30-60 seconds to wake up
- **Solution:** Use [UptimeRobot](https://uptimerobot.com/) to ping your site every 5 minutes (free)

### **Database (Supabase Free):**
- ✅ **500 MB storage** - plenty for portfolio
- ✅ **Never expires** - free forever!
- ✅ **Reliable** - 99.9% uptime
- ⚠️ Limited to 500 MB (upgrade to $25/month for 8 GB if needed)

### **Bandwidth:**
- 100GB/month free
- More than enough for a portfolio site

---

## 🔧 **Common Issues & Fixes**

### **Build Failed: "Ruby version mismatch"**
- Ensure `.ruby-version` file shows `3.1.4`
- Check Gemfile shows `ruby "3.1.4"`

### **App Crashes: "Missing RAILS_MASTER_KEY"**
- Add `RAILS_MASTER_KEY` to environment variables
- Get key from `config/master.key`

### **Database Connection Error**
- Ensure PostgreSQL database is created and linked
- Check `DATABASE_URL` is set automatically by Render

### **Assets Not Loading (CSS/JS missing)**
- Check build logs show: "Precompiling assets"
- Ensure `RAILS_SERVE_STATIC_FILES=enabled` is set

### **App URL Shows "Application Error"**
- Check logs: Click "Logs" in Render dashboard
- Look for error messages
- Common: Missing environment variables

---

## 📊 **Monitoring Your App**

### **View Logs:**
```
Render Dashboard → Your Service → "Logs" tab
```

### **Check Database:**
```
Render Dashboard → PostgreSQL → "Logs" tab
```

### **Performance:**
- Free tier: 512 MB RAM, 0.5 CPU
- Good enough for portfolios with low-moderate traffic
- Upgrade to $7/month for better performance

---

## 🔄 **Deploy Updates**

Future deployments are automatic:

1. Make changes locally
2. Commit to git: `git commit -am "Your changes"`
3. Push to GitHub: `git push`
4. Render auto-deploys (if auto-deploy enabled)

**Manual Deploy:**
```
Render Dashboard → Your Service → "Manual Deploy" → "Deploy latest commit"
```

---

## 💰 **Cost Breakdown**

**Completely Free Forever:**
- Web Service (Render): **$0** (with sleep)
- PostgreSQL (Supabase): **$0** (500 MB, never expires)
- UptimeRobot (prevent sleep): **$0**
- **Total: $0/month** ✅

**Recommended Paid (No Sleep):**
- Web Service (Render): **$7/month** (no sleep)
- PostgreSQL (Supabase): **$0** (keep free)
- **Total: $7/month**

**Production Ready:**
- Web Service (Render): **$7/month** (no sleep, better resources)
- PostgreSQL (Supabase Pro): **$25/month** (8 GB + extras)
- **Total: $32/month**

**Alternative (Budget Production):**
- Railway.app (web + db): **~$5-10/month**
- Includes everything, no sleep

---

## 🎯 **Next Steps After Deployment**

1. ✅ **Test your live site** - Visit your Render URL
2. ✅ **Set up UptimeRobot** to prevent sleeping
3. ✅ **Add custom domain** (optional, $0 on Render)
4. ✅ **Enable SSL** (automatic on Render)
5. ✅ **Set up error monitoring** (optional - Rollbar, Sentry)

---

## 📚 **Additional Resources**

- [Render Rails Guide](https://render.com/docs/deploy-rails)
- [Render Free Tier Limits](https://render.com/docs/free#free-web-services)
- [Custom Domains](https://render.com/docs/custom-domains)

---

## 🆘 **Need Help?**

**Check Logs First:**
```
Render Dashboard → Logs
```

**Common Commands:**
```bash
# Rails console
render run bundle exec rails console

# Database migrations
render run bundle exec rails db:migrate

# Check Rails environment
render run env | grep RAILS_ENV
```

**Support:**
- Render Community: [community.render.com](https://community.render.com)
- Render Docs: [render.com/docs](https://render.com/docs)

---

## ✅ **Deployment Checklist**

- [x] Ruby version set to 3.1.4
- [x] Gemfile dependencies updated
- [x] Security vulnerabilities fixed
- [x] Database configuration updated
- [x] Render.yaml created
- [x] Build script created
- [x] Changes pushed to GitHub
- [ ] RAILS_MASTER_KEY obtained
- [ ] Render account created
- [ ] Web service configured
- [ ] Database created and linked
- [ ] First deployment successful
- [ ] Database migrated
- [ ] Admin user created (if needed)
- [ ] Site tested and working
- [ ] UptimeRobot configured (optional)

---

**🎊 Congratulations! Your portfolio is now live on the internet! 🎊**
