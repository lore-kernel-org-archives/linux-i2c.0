From: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [PATCH] i2c: convert gpio-i2cmux to use module_platform_driver()
Date: Sun, 08 Jan 2012 12:24:21 +0100
Message-ID: <874nw6e8t6.fsf@thor.barco.com>
References: <1325986552.4442.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1325986552.4442.0.camel@phoenix> (Axel Lin's message of "Sun, 08Jan 2012 09:35:52 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "AL" == Axel Lin <axel.lin@gmail.com> writes:

AL> This patch converts gpio-i2cmux to use the module_platform_driver() macro which
AL> makes the code smaller and a bit simpler.

AL> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Peter Korsgaard <peter.korsgaard@barco.com>

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
