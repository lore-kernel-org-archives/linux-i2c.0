From: =?ISO-8859-1?Q?H=E5vard_Skinnemoen?= <havard-acdv5NTwJRiqeI1yJSURBw@public.gmane.org>
Subject: Re: [PATCH 06/16] i2c: i2c-gpio: remove __dev* attributes
Date: Tue, 27 Nov 2012 14:22:11 -0800
Message-ID: <CACiLriSQb1vP7d_JaTy37A908i7u+LK=m4Kuk9HF9_z9-VtxbA@mail.gmail.com>
References: <1354049993-12718-1-git-send-email-wfp5p@virginia.edu>
	<1354049993-12718-7-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1354049993-12718-7-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 27, 2012 at 12:59 PM, Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org> wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
>
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
>
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Havard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
