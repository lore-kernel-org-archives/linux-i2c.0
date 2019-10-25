From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
Date: Fri, 25 Oct 2019 10:21:51 +0530
Message-ID: <CAHO=5PGCZxBmbJ3rXM5WVLcRF3FecaLYFa7Rx3W=FeikpDHfuQ@mail.gmail.com>
References: <1569825869-30640-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20191024185540.GF1870@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191024185540.GF1870@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Michael Cheng <ccheng@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Lori Hikichi <lori.hikichi@broadcom.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Icarus Chau <icarus.chau@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 25, 2019 at 12:25 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Mon, Sep 30, 2019 at 12:14:29PM +0530, Rayagonda Kokatanur wrote:
> > From: Lori Hikichi <lori.hikichi@broadcom.com>
> >
> > Enable handling of i2c repeated start. The current code
> > handles a multi msg i2c transfer as separate i2c bus
> > transactions. This change will now handle this case
> > using the i2c repeated start protocol. The number of msgs
> > in a transfer is limited to two, and must be a write
> > followed by a read.
> >
> > Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > Signed-off-by: Icarus Chau <icarus.chau@broadcom.com>
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> > Signed-off-by: Shivaraj Shetty <sshetty1@broadcom.com>
>
> Patch looks good but doesn't apply for me on top of v5.4-rc4? What was
> your base?
>
> Also, I will apply it to for-next (v5.5). If you want it for v5.4, then
> please add a Fixes tag.
>
thank you, please apply it to for-next (v5.5).
Do I need to resend patch again for you to apply it to v5.5 ?
