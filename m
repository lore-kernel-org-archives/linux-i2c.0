From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] i2c-mux-gpio: Check gpio_direction_output return value
Date: Thu, 07 Mar 2013 09:45:40 +0100
Message-ID: <87obevvbrf.fsf@thor.barco.com>
References: <20130307093553.4bc1595f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <20130307093553.4bc1595f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org> (Jean Delvare'smessage of "Thu, 7 Mar 2013 09:35:53 +0100")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "JD" == Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> writes:

JD> gpio_direction_output() may fail, check for that and deal with it
JD> appropriately. Also log an error message if gpio_request() fails.

JD> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
JD> Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
JD> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
