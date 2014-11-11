From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH V2] i2c-designware: Add Intel Baytrail PMIC I2C bus
 support
Date: Tue, 11 Nov 2014 13:50:28 +0200
Message-ID: <20141111115028.GH1454@lahna.fi.intel.com>
References: <1410543367-6565-1-git-send-email-david.e.box@linux.intel.com>
 <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411497626-7984-1-git-send-email-david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 23, 2014 at 11:40:26AM -0700, David E. Box wrote:
> +void baytrail_evaluate_sem(struct dw_i2c_dev *dev)
> +{
> +	acpi_status status;
> +	unsigned long long shared_host = 0;
> +	acpi_handle handle;
> +
> +	if (!dev || !dev->dev) {
> +		pr_err("%s:%d: device is NULL\n", __func__, __LINE__);

Not sure if it is useful to print things like above.

> +		return;
> +	}
> +
> +	handle = ACPI_HANDLE(dev->dev);
> +	if (!handle)
> +		return;
> +
> +	status = acpi_evaluate_integer(handle, "_SEM", NULL, &shared_host);

Maybe it is better to check first if the operation succeeded before
touching shared_host?

	if (ACPI_SUCCESS(status) && shared_host) {
	}

Otherwise ACPI parts look good to me.

> +
> +	if (shared_host) {
> +		dev_info(dev->dev, "I2C bus managed by PUNIT\n");
> +		dev->has_hw_lock = true;
> +		dev->pm_runtime_disabled = true;
> +	}
> +}
> +EXPORT_SYMBOL(baytrail_evaluate_sem);
