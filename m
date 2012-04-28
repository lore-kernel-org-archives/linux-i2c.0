From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: Rename last mux driver to standard pattern
Date: Sat, 28 Apr 2012 16:11:27 +0200
Message-ID: <87lilghrow.fsf@thor.barco.com>
References: <20120428153206.00c1e226@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <20120428153206.00c1e226-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare'smessage of "Sat, 28 Apr 2012 15:32:06 +0200")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

JD> Update the MAINTAINERS entry and all other references accordingly.
JD> Based on an original patch by Wolfram Sang.

JD> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
JD> Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
JD> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
JD> ---
JD> Peter, I assumed your ack still applied, please yell if not.

It does, thanks.

JD> Changes since v1:
JD> * Renamed header file and documentation file too.
JD> * Updated MAINTAINERS.
JD> * Updated references.

JD>  Documentation/i2c/muxes/gpio-i2cmux  |   65 ------------
JD>  Documentation/i2c/muxes/i2c-mux-gpio |   65 ++++++++++++
JD>  MAINTAINERS                          |    6 -
JD>  drivers/i2c/muxes/Kconfig            |    2 
JD>  drivers/i2c/muxes/Makefile           |    2 
JD>  drivers/i2c/muxes/gpio-i2cmux.c      |  173 ----------------------------------
JD>  drivers/i2c/muxes/i2c-mux-gpio.c     |  173 ++++++++++++++++++++++++++++++++++
JD>  include/linux/gpio-i2cmux.h          |   38 -------
JD>  include/linux/i2c-mux-gpio.h         |   38 +++++++

git diff -M patches are a lot easier to read for this kind of change.

-- 
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
