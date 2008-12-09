From: "roel kluin" <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 12/33] i2c: Make static
Date: Tue, 9 Dec 2008 23:53:27 +0100
Message-ID: <25e057c00812091453r79884cb7oa19224aa9e4d12fd@mail.gmail.com>
References: <493EA286.7080500@gmail.com> <493EBBD0.6070201@gmail.com>
	 <20081209200409.17fac29f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081209200409.17fac29f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Nack:
>
> drivers/i2c/i2c-core.c:EXPORT_SYMBOL(i2c_smbus_process_call);
>
> --
> Jean Delvare
>

Again thanks for reporting, fortunately it appears that this only occurred
in a few other patches.

Roel
