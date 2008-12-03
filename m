From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
Date: Tue, 02 Dec 2008 18:27:23 -0800
Message-ID: <4935EE8B.80708@consentry.com>
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>	 <49347317.5080600@consentry.com> <1228207199.9867.69.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1228207199.9867.69.camel-/EMGr9iCeazgSi9v3i4K4Pmbkio/vSLMs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jocke,

> The I2C_CHIP_ERRATA is mine and refers to mpc8xx, mpc860 in my case. The
> driver was adapted by me some years ago in 2.4 and now someone has
> ported it to 2.6 it seems.

Thanks for the background info.  Any idea which particular errata it
was meant to fix?  I took a quick look at MPC860 errata document and it
seems that CPM5 and CPM6 both suggest this workaround.

I don't think any of the 8xx CPM errata are present on 82xx, but it
would be good to enable the same or similar workaround on CPM2 for
82xx erratum CPM98, probably even when I2C_CHIP_ERRATA is not defined.

					-=] Mike [=-
