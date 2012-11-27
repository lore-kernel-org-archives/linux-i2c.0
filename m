From: "Peter Korsgaard" <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/16] i2c: mux-gpio: remove __dev* attributes
Date: Tue, 27 Nov 2012 23:44:14 +0100
Message-ID: <87boeivf7l.fsf@thor.barco.com>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu><1354049993-12718-3-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <1354049993-12718-3-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org> (BillPemberton's message of "Tue, 27 Nov 2012 15:59:39 -0500")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "BP" == Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org> writes:

BP> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
BP> markings will be going away.

BP> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
BP> and __devexit.

BP> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
BP> Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

Acked-by: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
