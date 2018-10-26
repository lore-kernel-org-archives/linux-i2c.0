From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v10 0/9] Add the I3C subsystem
Date: Fri, 26 Oct 2018 18:30:04 +0200
Message-ID: <20181026183004.4857ce73@bbrezillon>
References: <20181026144333.12276-1-boris.brezillon@bootlin.com>
        <ad79f586-860e-bf57-9970-f58dc16d33b8@synopsys.com>
        <20181026181548.53228a4b@bbrezillon>
        <87738b8d-8033-9ef1-b0fb-059b64b0dc96@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87738b8d-8033-9ef1-b0fb-059b64b0dc96@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vitor <vitor.soares@synopsys.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetr>
List-Id: linux-i2c@vger.kernel.org

On Fri, 26 Oct 2018 17:20:42 +0100
vitor <vitor.soares@synopsys.com> wrote:

> On 26/10/18 17:15, Boris Brezillon wrote:
> > On Fri, 26 Oct 2018 16:22:06 +0100
> > vitor <vitor.soares@synopsys.com> wrote:
> >  
> >> Can you update the i3c/next tree?  
> > Done.  
> 
> Thanks.
> 
> I will apply the driver and them I give you feedback.

Great! Note that the bug in the ->send_ccc_cmd() path should be fixed,
but you might have issues with i2c transfers as msg->buf is not
guaranteed to be aligned on 32-bit.

Don't know if you've followed the discussion with Arnd, but it seems
some (most?) archs are making sure writesl()/readsl() work for
unaligned bufs. Maybe we should fix that for ARC. The other solution is
to use i2c_get_dma_safe_msg_buf() to get something aligned on a
cache-line and by extension aligned on 32bits.
