From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Date: Mon, 29 Oct 2018 15:27:43 +0100
Message-ID: <1607303.K3FPNFt9tg@pcbe13614>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com> <20181029085259.GA4101@kunai>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029085259.GA4101@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Monday, October 29, 2018 9:53:01 AM CET Wolfram Sang wrote:
> On Sun, Oct 21, 2018 at 04:12:10PM +0200, Peter Korsgaard wrote:
> > On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> 
wrote:
> > > If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> > > - the line can be shared with other devices
> > > - it can be a spurious interrupt
> > > 
> > > To avoid reading twice the status register, the ocores_process()
> > > function
> > > expects it to be read by the caller.
> > > 
> > > Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> > 
> > Looks good.
> > 
> > Acked-by: Peter Korsgaard <peter@korsgaard.com>
> 
> I assume this patch will be resent when the other patches get updated?
> Or shall I pick this one independently of the others?

Since Peter did not answer yet, I would say to wait because I'm going to re-
send the full patch-set soon.
