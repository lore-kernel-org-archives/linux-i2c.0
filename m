From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v6 2/2] i2c: i2c-ocores: Add support for the GRLIB port of the controller and use function pointers for getreg and setreg functions
Date: Thu, 15 Nov 2012 17:38:31 +0100
Message-ID: <87y5i23jp4.fsf@dell.be.48ers.dk>
References: <1352994659-22392-1-git-send-email-andreas@gaisler.com>
	<1352994659-22392-3-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352994659-22392-3-git-send-email-andreas@gaisler.com> (Andreas
	Larsson's message of "Thu, 15 Nov 2012 16:50:59 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Larsson <andreas@gaisler.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, software@gaisler.com
List-Id: linux-i2c@vger.kernel.org

>>>>> "Andreas" == Andreas Larsson <andreas@gaisler.com> writes:

 Andreas> The registers in the GRLIB port of the controller are 32-bit
 Andreas> and in big endian byte order. The PRELOW and PREHIGH registers
 Andreas> are merged into one register. The subsequent registers have
 Andreas> their offset decreased accordingly. Hence the register access
 Andreas> needs to be handled in a non-standard manner using custom
 Andreas> getreg and setreg functions.

 Andreas> Add setreg and getreg functions for different register widths
 Andreas> and let oc_setreg and oc_getreg use function pointers to call
 Andreas> the appropriate functions.

 Andreas> A type is added as the data of the of match table entries. A
 Andreas> new entry with a different compatible string is added to the
 Andreas> table. The type of that entry triggers usage of the custom
 Andreas> grlib functions by setting the setreg and getreg function
 Andreas> pointers.

 Andreas> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

Thanks!

-- 
Bye, Peter Korsgaard
