From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: bfin: turn to Resource-managed API in probe function
Date: Wed, 21 May 2014 10:05:30 +0200
Message-ID: <20140521080530.GD2708@katana>
References: <1394445784-4653-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394445784-4653-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adi-buildroot-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> @@ -646,22 +646,19 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res == NULL) {
>  		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
> -		rc = -ENOENT;
> -		goto out_error_get_res;
> +		return -ENOENT;

You don't need to check the resource. devm_ioremap_resource will do it.

> -	iface->regs_base = ioremap(res->start, resource_size(res));
> -	if (iface->regs_base == NULL) {
> +	iface->regs_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR((void *)iface->regs_base)) {
>  		dev_err(&pdev->dev, "Cannot map IO\n");
> -		rc = -ENXIO;
> -		goto out_error_ioremap;
> +		return PTR_ERR((void *)iface->regs_base);

Do we need the casts?

> @@ -740,8 +728,6 @@ static int i2c_bfin_twi_remove(struct platform_device *pdev)
>  	i2c_del_adapter(&(iface->adap));
>  	free_irq(iface->irq, iface);
>  	peripheral_free_list(dev_get_platdata(&pdev->dev));
> -	iounmap(iface->regs_base);
> -	kfree(iface);

You missed to remove the free irq.

Have you actually tried unloading the module?


--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTfF5KAAoJEBQN5MwUoCm2LWIQAKMSDM0JBva5rZK4HVMoZpuX
M7KYyWbEhEulb9BP7bSzO1MGGDHHfRMohG8K4sWdUzwBtNThTBmz3ZI3VIrs90JN
3lwx9OCPQFtlExC6SBvKk2XDWrFora1OoqtAaqp5VUoDJAXOhbEjSzazJ1PTmwng
4gl3EUdlKDwEzuJ9N+SSGKasUPhRWrGbzlfhRLW7DXhNmcOvF3pJUnSdJcsnImTM
4cdT67ILULNY/UchcYSvQ5Nd4C0ac1rjv6YgUeTRwDAsSsWSZbUS0e6AXTbd2/pk
NU+uFcgqw2XV8fcHiuVcJnScSPSTLgztYTMc7UDKcCq5GItnx4lmj9Ag6wtKagzP
YhPumf/TSQRy09KRKho/qN0zqVsnJifUfJsT+EHnL1ZUr8a/dWtrcD4sgfGQFNQU
hiydrotCLdYVwsrKxDKU7SU+ZK/OFb7g6TmMnfwXdgz2fbNdm8mB6nIzBs1SQ1xs
j3hYnHFxQjWt08j5IFbHPExZ+RvHXCFV0KsHrOFb2CjDgmhAYhTr2JIoIgQTvowP
/D+30E05HOZgS/Qf94xlwqr4ULMms+f7jtcvwZsEjF91/lTT7bqKAa0CyQ0UyIjZ
7hdMgb9fj8q+bOMJeDoaFdWSYOxpSdQTqhMmFTtgrE2xFkj1dpGmeDyJ5bff/fSu
dHhEbqWc3958puT+FsIw
=QQE4
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
