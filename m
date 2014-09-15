From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Intel BayTrail PMIC I2C bus support
Date: Mon, 15 Sep 2014 09:55:45 -0700
Message-ID: <20140915165545.GA2039@pathfinder>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
 <54168DE2.8020303@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54168DE2.8020303-qxv4g6HH51o@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Maxime,

On Mon, Sep 15, 2014 at 08:57:38AM +0200, Maxime Coquelin wrote:

> >+		err = dev->acquire_ownership(dev->dev);
> Have you considered using hwspinlocks instead?

No, I've not used it before but it looks applicable here. I'll take a look.

> >@@ -212,6 +259,25 @@ static int dw_i2c_probe(struct platform_device *pdev)
> >  	adap->dev.parent = &pdev->dev;
> >  	adap->dev.of_node = pdev->dev.of_node;
> >
> >+#if IS_ENABLED(CONFIG_I2C_SHARED_CONTROLLER)
> >+	if (dev->shared_host)
> >+		adap->algo = &i2c_sc_algo;
> >+
> >+	r = i2c_add_numbered_adapter(adap);
> >+	if (r) {
> >+		dev_err(&pdev->dev, "failure adding adapter\n");
> >+		return r;
> >+	}
> >+
> >+	if (dev->shared_host)
> >+		pm_runtime_forbid(&pdev->dev);
> >+	else {
> >+		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> >+		pm_runtime_use_autosuspend(&pdev->dev);
> >+		pm_runtime_set_active(&pdev->dev);
> >+		pm_runtime_enable(&pdev->dev);
> >+	}
> >+#else
> Why do you put all this under config flags?

So that this additional code only compiles for this very specific
implementation.

> >@@ -268,7 +334,11 @@ static int dw_i2c_resume(struct device *dev)
> >  	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
> >
> >  	clk_prepare_enable(i_dev->clk);
> >-	i2c_dw_init(i_dev);
> >+
> >+#if IS_ENABLED(CONFIG_I2C_SHARED_CONTROLLER)
> >+	if (!i_dev->shared_host)
> >+#endif
> Putting this under config flag should not be needed.
> 
> And even not under config flags, why don't you re-initialize your
> device in case of resume?

Because the device is already being managed by hardware, not the OS.

David Box
