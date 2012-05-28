From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ocore: register OF i2c devices
Date: Mon, 28 May 2012 23:31:15 +0200
Message-ID: <8762bg6li4.fsf@macbook.be.48ers.dk>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
	<1336483529-19140-2-git-send-email-jayachandranc@netlogicmicro.com>
	<20120512145205.GL20673@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120512145205.GL20673-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> (Wolfram Sang's message
	of "Sat, 12 May 2012 16:52:05 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Wolfram" == Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> writes:

 Wolfram> On Tue, May 08, 2012 at 06:55:28PM +0530, Jayachandran C wrote:
 >> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
 >> 
 >> Call of_i2c_register_devices() in probe function to register i2c devices
 >> specified in the device tree or OF.
 >> 
 >> Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
 >> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

 Wolfram> Applied to next with a minor fixup.

 Wolfram> More important: If you are happily using this driver without issues,
 Wolfram> please consider removing EXPERIMENTAL for this driver from Kconfig.

And also please consider CC'ing the maintainer on patches (E.G. me) - I
didn't notice this before now.

-- 
Bye, Peter Korsgaard
