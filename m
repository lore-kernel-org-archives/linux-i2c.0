From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Date: Fri, 4 Sep 2015 13:33:39 +0900
Message-ID: <CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
	<5464456.UnsMOS3MTx@avalon>
	<20150903204000.GB1574@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150903204000.GB1574@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Sep 4, 2015 at 5:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > So I refactored the driver to setup new messages in interrupt context, too.
>> > This avoids the race for b) because we are now setting up the new message
>> > before we release the i2c bus clock (before we released the clock and set up
>> > the message in process context).
>>
>> Could this fix the HDMI EDID read issue on Koelsch ?
>
> I surely hope so. I can't test because I don't have Koelsch.

FYI, I have enabled Koelsch remote access on port 8001 if you want to
give it a shot!

Cheers,

/ magnus
