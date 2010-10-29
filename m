From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v2 1/1] NFC: Driver for NXP Semiconductors PN544 NFC
 chip.
Date: Fri, 29 Oct 2010 14:35:00 -0700
Message-ID: <20101029143500.bc1cbc7d.akpm@linux-foundation.org>
References: <1288333569-19979-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1288333569-19979-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1288333569-19979-2-git-send-email-matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 29 Oct 2010 09:26:09 +0300
"Matti J. Aaltonen" <matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> wrote:

> +static void __exit pn544_exit(void)
> +{
> +	flush_scheduled_work();

You said this had been removed.  Did you send the correct version?

> +	i2c_del_driver(&pn544_driver);
> +	pr_info(DRIVER_DESC ", Exiting.\n");
> +}
