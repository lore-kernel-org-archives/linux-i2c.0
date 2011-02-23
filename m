From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST	controller
Date: Wed, 23 Feb 2011 10:46:39 +0100
Message-ID: <8739nfytfk.fsf@macbook.be.48ers.dk>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com>
	<20110216142708.GA6365@pengutronix.de> <4D5BE45F.5020908@gaisler.com>
	<20110223010703.GA15795@trinity.fluff.org>
	<4D64D5AC.3060301@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D64D5AC.3060301-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> (Jan Andersson's message of "Wed,
	23 Feb 2011 10:38:52 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jan" == Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org> writes:

Hi,

 Jan> The register field definitions can currently be shared. The register
 Jan> offsets (steps) are different since the two prescaler registers have
 Jan> been merged into one register on the i2cmst core.

 Jan> For V2 I will move the register field defines from i2c-ocores.c to
 Jan> i2c-ocores.h and include that file in the new driver - unless anyone
 Jan> objects.

Ben, do you really think that's worthwhile? It's just 6 registers with a
few bits in 3 of them.

-- 
Bye, Peter Korsgaard
