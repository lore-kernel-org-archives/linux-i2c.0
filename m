From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
Date: Mon, 17 Sep 2018 11:48:09 -0700
Message-ID: <20180917184809.GA16057@roeck-us.net>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
 <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
 <20180917163401.GA1082@kunai>
 <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <037b4cf8-5dfa-d554-b126-a2462ba9c803@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Brendan Higgins <brendanhiggins@google.com>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 17, 2018 at 10:16:59AM -0700, Jae Hyun Yoo wrote:
> On 9/17/2018 9:34 AM, Wolfram Sang wrote:
> >
> >>Looks good to me. Thanks! :)
> >>
> >>Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> >
> >Does that mean I need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle
> >master/slave combined irq events properly" in i2c/for-next? And apply
> >this to i2c/for-current?
> >
> 
> No need to revert "[PATCH i2c-next v6] i2c: aspeed: Handle master/slave
> combined irq events properly". This patch should be applied on top of
> the patch.
> 
Yes, sorry, I should have tagged the patch as for-next.

Guenter
