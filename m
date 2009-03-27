From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: what is in bjdooks' i2c-for-2630 tree
Date: Fri, 27 Mar 2009 18:25:22 +0000
Message-ID: <20090327182522.GA13372@sirena.org.uk>
References: <E1Ln9pC-00037e-Qn@teyla.home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1Ln9pC-00037e-Qn-fIsYBodh/r28n8r38hOLvmD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dsilvers-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2009 at 11:02:10AM +0000, Ben Dooks wrote:
> The following changes since commit 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84:
>   Linus Torvalds (1):
>         Linux 2.6.29

> are available in the git repository at:

>   git://aeryn.fluff.org.uk/bjdooks/linux.git i2c-for-2630

There was also a change I posted a while ago to initialise the S3C I2C
driver earlier in order to allow I2C devices to be used earlier in init
- this is useful for things like regulators which are expected to be
configured very early on.  Were there any problems with it?
