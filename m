From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-parport: start using pr_fmt
Date: Wed, 17 Jun 2015 19:50:28 +0530
Message-ID: <20150617142028.GA19542@sudip-PC>
References: <1434093434-30834-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150617114617.GB4604@schokonusskuchen.bad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150617114617.GB4604-oo5tB6JMkjKRinMKxDlMNPwbnWRJjS81@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 17, 2015 at 01:46:17PM +0200, Wolfram Sang wrote:
> On Fri, Jun 12, 2015 at 12:47:14PM +0530, Sudip Mukherjee wrote:
> > Start using pr_fmt and convert all remaining printk to use
> > pr_* family of macros.
> 
> I heard you introduced the driver model to parport. So, isn't there a
> struct device we could use for dev_err() and friends?
adding pr_fmt was discussed with Jean many days ago. This patch is a
result of that. I will have a look at using dev_* family here.

regards
sudip
> 
> Thanks,
> 
>    Wolfram
