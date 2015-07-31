From: Robert Abel <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Subject: Fwd: [PATCH 0/6] i2c: Xilinx IIC: rework driver
Date: Fri, 31 Jul 2015 22:53:11 +0200
Message-ID: <CAMdRc4ETsavgumm_A-Bqufb2jZwqeyEkAsxfCwCYgaKuGwS7XA@mail.gmail.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<CAKfKVtG6rRyb70Mxe46Rd9czkx6kSaf91pTeysRf78vtpypFBA@mail.gmail.com>
	<CAMdRc4EmQN7SAxgcuauowuz5vOvNn2QYsv99=yUNQOSFRVVr8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMdRc4EmQN7SAxgcuauowuz5vOvNn2QYsv99=yUNQOSFRVVr8Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Shubhrajyoti,

On Fri, Jul 31, 2015 at 3:55 PM Shubhrajyoti Datta
<shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> - offlist
> On Fri, Jul 31, 2015 at 5:30 PM, Robert ABEL
> <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org> wrote:
> >
> > This patch series completely reworks Xilinx' XIIC driver. Short sum=
mary:
> > Driver didn't work for me and I don't know how it could ever have w=
orked for anybody.
> > So I rewrote it in big parts and now it works for me=E2=84=A2.
> >
>
> Are you reporting a regression because of the below patches?
> Or it never worked for you?


The XIIC driver never worked for me. The mainline version before your
patches would enter BNB interrupt immediately. The linux-xlnx version
dereferenced a null pointer, because the IRS modified
i2c->tx_msg/i2c->rx_msg while the initial messages were copied to the
TX FIFO.

I think both behaviors might have been due to the TX FIFO running
empty while not all messages were copied, because xiic was pre-empted.
Or maybe something was wrong with the I=C2=B2C SDA/SCL lines. Either wa=
y,
code did not account for any errors, any preemption, so I'm unsure how
the xiic driver works for anybody else.

Regards

Robert
