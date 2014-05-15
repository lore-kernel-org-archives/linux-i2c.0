From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH V2] i2c: ocores: Make of_device_id array const
Date: Thu, 15 May 2014 08:35:34 +0200
Message-ID: <87lhu3tuq1.fsf@dell.be.48ers.dk>
References: <005801cf6fca$af7fd0e0$0e7f72a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <005801cf6fca$af7fd0e0$0e7f72a0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> (Jingoo Han's
	message of "Thu, 15 May 2014 08:17:33 +0900")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Maxime COQUELIN' <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jingoo" == Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> writes:

You seem to have forgotten to change subject, but I guess Wolfram can
fix that when committing (E.G. s/ocores/busses/).

 > Make of_device_id array const, because all OF functions
 > handle it as const.

 > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
 > Acked-by: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
 > Acked-by: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
 > ---
 > Changes since v1:
 > - squashed all patches into a single patch
 > - added acked-by

-- 
By, Peter Korsgaard 
