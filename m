From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 0/3] i2c-mux-gpio: Split plat- and dt-specific code up
Date: Tue, 7 May 2019 12:46:16 +0300
Message-ID: <20190507094615.xrmuaokro3ll4ghg@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190425232028.9333-1-fancer.lancer@gmail.com>
 <20190507090210.hn6vgcjg2q6tysbp@mobilestation>
 <689e1a7b-8544-6bbf-2fa1-a5845895a917@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <689e1a7b-8544-6bbf-2fa1-a5845895a917@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Serge Semin <Sergey.Semin@t-platforms.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hello Peter

On Tue, May 07, 2019 at 09:17:38AM +0000, Peter Rosin wrote:
> On 2019-05-07 11:02, Serge Semin wrote:
> > Hello folks,
> > 
> > Any updates on this patchset status? I haven't got any comment on v2, but
> > instead a notification about the status change was sent to me:
> > 
> >> * linux-i2c: [v2,1/3] i2c-mux-gpio: Unpin a platform-based device initialization
> >>     - http://patchwork.ozlabs.org/patch/1091120/
> >>     - for: Linux I2C development
> >>    was: New
> >>    now: Superseded
> >>
> >> * linux-i2c: [v2,2/3] i2c-mux-gpio: Unpin the platform-specific GPIOs request code
> >>     - http://patchwork.ozlabs.org/patch/1091122/
> >>     - for: Linux I2C development
> >>    was: New
> >>    now: Superseded
> >>
> >> * linux-i2c: [v2,3/3] i2c-mux-gpio: Create of-based GPIOs request method
> >>     - http://patchwork.ozlabs.org/patch/1091121/
> >>     - for: Linux I2C development
> >>    was: New
> >>    now: Superseded
> > 
> > I may misunderstand something, but how come the v2 patchset switched to be superseded
> > while it is the last patchset version I've sent?
> 
> That was my mistake. Patchwork got confused when v2 was sent as a reply to
> something in the v1 tree, and marked all 8 patches as "v2". Then I in turn
> got confused by that, and changed status on the wrong set. Sorry!
> 
> So, thanks for the heads up, it should be fixed now.
> 
> As for comments on the patches, I'm personally buried in work and others
> may have the merge window to focus on...
> 
> Cheers,
> Peter

No worries. Glad everything is clear now. Thanks for the quick response.

Regarding the patchset comments. Lets wait for the merge window being closed.
Then if no comments will have been received in one-two weeks after that I'll
ping this patchset mailing-list again .)

Cheers,
-Sergey
