From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: RE: [PATCH] i2c: cadence: Handling Slave monitor mode
Date: Sat, 4 Apr 2015 13:14:31 +0000
Message-ID: <9ef3c612-b803-4937-bb21-0fac03969f39@BN1AFFO11FD037.protection.gbl>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
 <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
 <20150402202909.GA3501@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150402202909.GA3501@katana>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>, Harini Katakam <harinikatakamlinux@gmail.com>
Cc: Srikanth Vemula <svemula@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


> -----Original Message-----
> From: Wolfram Sang [mailto:wsa@the-dreams.de]
> Sent: Friday, April 03, 2015 1:59 AM
> To: Harini Katakam
> Cc: Nava kishore Manne; Michal Simek; Soren Brinkmann; linux-arm-
> kernel@lists.infradead.org; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; Anirudha Sarangi; Srikanth Vemula; Nava kishore
> Manne
> Subject: Re: [PATCH] i2c: cadence: Handling Slave monitor mode
>
>
> > >> In slave monitor mode, the I2C interface is set up as a master and
> > >> continues to attempt a transfer to a particular slave until the
> > >> slave device responds with an ACK.
> > >>
> > >> Added this feature for zero length transfers enable the controller
> > >> for slave monitor interrupt and get the status. Disable the slave
> > >> monitor mode feature upon successful handling.
> > >>
> > >> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> > >> Acked-by: Harini Katakam <harinik@xilinx.com>
> > >
> > > I am not sure this is going to work.
> > >
> > > How often is this access tried when there is no device? It should be
> > > tried only once.
> >
> > Once slave monitor is enabled in the host controller, it retries till
> > there's an ACK or slave monitor is disabled. The SW wont be involved
> > and need not
>
> So, it is kind of flooding the bus until the timeout? That is not a single zero
> byte message.
>
It will not flooding the bus until the timeout. Once it fails to access the bus it will be ideal for 15 clock cycles. Master again retrying to access the
Slave immediately after the 15 clock cycles (There is a register in the controller to set the retry value min: 0 cycles, max: 16 cycles).This process will repeat until
The software timeout will happen (1000msec).

Regards,
Navakishore.
> > be interrupted in this gap. The way this feature works in the
> > controller though, I'm afraid there's no way to distinguish between no
> slave/ busy slave.
> > The out is the software timeout in that case.
> > Please suggest how to use this feature better.
>
> I suggest to not use the feature and accept that this device cannot do zero
> byte length messages.
>
> Thanks,
>
>    Wolfram



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
