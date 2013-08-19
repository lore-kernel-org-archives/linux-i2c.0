From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 05/35] i2c: use dev_get_platdata()
Date: Mon, 19 Aug 2013 10:29:31 +0900
Message-ID: <015c01ce9c7b$8da0f710$a8e2e530$@samsung.com>
References: <003701ce8cfa$ba3fd060$2ebf7120$@samsung.com>
 <20130815180321.GB5934@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20130815180321.GB5934@katana>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: 'Wolfram Sang' <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, August 16, 2013 3:03 AM, Wolfram Sang wrote:
> On Tue, Jul 30, 2013 at 04:59:33PM +0900, Jingoo Han wrote:
> > Use the wrapper function for retrieving the platform data instead of
> > accessing dev->platform_data directly.
> >
> > Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> Not convincing. I couldn't find a cover letter explaining the motivation
> and if this should go via the seperate trees or via one cleanup pull
> request. (and if there is one, the i2c list should be on cc) Also, all

CC'ed Mark Brown (author of dev_get_platdata function)

1. Motivation
This is a cosmetic change by in order to enhance readability and make
the code simpler.

If you want, I will modify the commit message as below:
"Use the wrapper function for retrieving the platform data instead of
 accessing dev->platform_data directly. This is a cosmetic change
 in order to enhance readability and make the code simpler."

2. via the separate trees
It should go via the separate trees.

> 35 patches seem to be seperate mails and not threaded, so I can't easily
> check other opinions. Will skip for now unless somebody points out a
> strong reason.

3. Other opinions
Until now, there is no objection.
Also, 21 patches of all 35 patches have been applied by each maintainer.

Mark Brown,
Sorry for CC'ing you.
If I am wrong, please let me know kindly. :)

Best regards,
Jingoo Han
