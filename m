From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 08/16] i2c: ocores: remove __dev* attributes
Date: Tue, 27 Nov 2012 14:55:36 -0800
Message-ID: <87ehje1wrb.fsf@dell.be.48ers.dk>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
	<1354049993-12718-9-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-9-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org> (Bill
	Pemberton's message of "Tue, 27 Nov 2012 15:59:45 -0500")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Bill" == Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org> writes:

 Bill> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
 Bill> markings will be going away.

 Bill> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
 Bill> and __devexit.

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

-- 
Bye, Peter Korsgaard
