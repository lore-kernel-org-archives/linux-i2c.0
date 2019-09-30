From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v2 1/1] i2c: iproc: Add i2c repeated start capability
Date: Mon, 30 Sep 2019 12:22:59 +0530
Message-ID: <CAHO=5PHj1PQUGi3EYBPVNUsRHsEo9WxU6CsvR=9+bP4n6z-cMA@mail.gmail.com>
References: <1569472808-15284-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <20190928181910.GB12219@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190928181910.GB12219@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Michael Cheng <ccheng@broadcom.com>, Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>, Lori Hikichi <lori.hikichi@broadcom.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Icarus Chau <icarus.chau@broadcom.com>, Ray Jui <ray.jui@broadcom.com>, Shivaraj Shetty <sshetty1@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

On Sat, Sep 28, 2019 at 11:53 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Thu, Sep 26, 2019 at 10:10:08AM +0530, Rayagonda Kokatanur wrote:
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
> > ---
> > changes from v1:
> >  - Address code review comment from Wolfram Sang
>
> No, sorry, this is not a proper changelog. I review so many patches, I
> can't recall what I suggested to do for every patch. Please describe
> what changes you actually made. It is also better when digging through
> mail archives.
>
Sorry for inconvenience, I updated the changelog and resent the patch.
I have kept the patch version as v2 only. Hope that is fine.

Best regards,
Rayagonda
