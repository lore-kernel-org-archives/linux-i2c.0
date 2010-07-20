From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v2] gpio: sx150x: Add Semtech I2C sx150x gpio expander
	driver.
Date: Tue, 20 Jul 2010 10:25:35 +0100
Message-ID: <20100720092534.GE7002@sirena.org.uk>
References: <1278617834-14970-1-git-send-email-gbean@codeaurora.org> <20100719163142.16cab271.akpm@linux-foundation.org> <20100719165038.a308b019.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100719165038.a308b019.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Gregory Bean <gbean-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 19, 2010 at 04:50:38PM -0700, Andrew Morton wrote:
> Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> > Meanwhile I'll do s/tristate/bool/.

> Which of course didn't work because i2c is a module.

The standard fix all the other affected drivers are doing is

	depends on I2C=y
