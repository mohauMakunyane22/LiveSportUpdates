# 🚀 LiveSportUpdates Deployment Guide

## ⚡ RECOMMENDED: Deploy with Vercel (Easiest Option)

Vercel is perfect for your Node.js + React stack and has a generous free tier.

### Step 1: Install Vercel CLI
```bash
npm i -g vercel
```

### Step 2: Configure for Vercel
1. Create `vercel.json` in your root directory (already created for you)
2. Build your frontend: `cd frontend && npm run build`
3. Run: `vercel` in your root directory
4. Follow the prompts:
   - Set up and deploy? **Y**
   - Which scope? Choose your account
   - Link to existing project? **N**
   - Project name: **livesportupdates**
   - Directory: **. (current directory)**

### Step 3: Environment Variables
In Vercel dashboard, add these environment variables:
- `NODE_ENV`: `production`

Your app will be live at: `https://livesportupdates-[random].vercel.app`

---

## 🔷 Alternative: Azure App Service (More Complex)

If you prefer Azure, use the `deploy-azure-student.sh` script:

```bash
./deploy-azure-student.sh
```

**Important Values for Azure:**
- **Region**: `southafricanorth` (only available region for your account)
- **Pricing**: `F1` (Free tier)
- **Runtime**: `Node 20 LTS`

---

## 📋 What You Need to Provide:

### For Vercel (Recommended):
1. Vercel account (free at vercel.com)
2. GitHub repository (optional but recommended)

### For Azure:
1. Azure account (you have Azure for Students)
2. Choose these values:
   - **Resource Group**: Auto-generated unique name
   - **App Service Plan**: Auto-generated unique name
   - **App Name**: Auto-generated unique name
   - **Location**: `southafricanorth`
   - **SKU**: `F1` (Free)

---

## 🎯 Next Steps After Deployment:

1. **Test your deployment**
2. **Set up continuous deployment** (GitHub Actions or Vercel Git integration)
3. **Configure custom domain** (optional)
4. **Set up monitoring** and error tracking

---

## 💡 Recommendation:

**Start with Vercel** - it's much simpler, faster, and perfect for your stack. You can always migrate to Azure later when your app grows.
