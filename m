From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: Re: [v2 0/3] Fix issues reported by Coccinelle
Date: Sun, 22 Sep 2019 22:39:06 +0530
Message-ID: <20190922170906.GB5589@SD>
References: <20190917172758.GA11926@SD>
 <76e99512-8818-cec2-9e77-799e4c8481ab@web.de>
 <20190917181423.GB28182@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190917181423.GB28182@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Markus.Elfring@web.de
Cc: Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 17, 2019 at 08:14:23PM +0200, Wolfram Sang wrote:
> On Tue, Sep 17, 2019 at 08:10:45PM +0200, Markus Elfring wrote:
> > > Using cocciecheck to ensure there are no semantic issues in
> > > i2c-qup driver.
> > 
> > * This wording contains a typo.
> 
> Doesn't matter to me for a cover letter as long as we can understand it.
> 
> > * I would prefer to refer to a desired reduction of a few
> >   source code quality concerns.
> 
> Not needed. I understand what is going on here.

Markus - By "ensure", I mean there are no further cocciecheck issues at this
point in time. And further, what changed is covered in individual patch
changelog. So, I think this information is fine in cover.

> > Can such a prefix be omitted?
Can be, but I like to keep it.

Thanks for review.

-Saiyam
