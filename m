From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH V2 0/5] i2c:ocores: improvements
Date: Tue, 15 Jan 2019 17:37:07 +0100
Message-ID: <14601911.GrvbWtgO0l@pcbe13614>
References: <20181029145051.31984-1-federico.vaga@cern.ch> <20181127113821.GB1107@kunai>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127113821.GB1107@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi there,

I just want to ask if there has been any update about this patchset that I'm 
not aware off. Thanks

On Tuesday, November 27, 2018 12:38:22 PM CET Wolfram Sang wrote:
> > This patch set provides improvements to the i2c-ocore driver.
> > 
> > [V1 -> V2]
> > - replaced usleep_range() with udelay() so that the polling version can be
> > 
> >   used in atomic context.
> > 
> > - added dedicated patch for minor style issues
> > - fixed delay computation
> > - use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is
> > always> 
> >   necessary and a trylock would generate an extra interrupt for nothing
> > 
> > - make the driver ready for an eventual master_xfer_irqless()
> 
> Peter, do you have a time slot to review this?
