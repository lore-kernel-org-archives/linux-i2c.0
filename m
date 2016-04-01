From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Date: Sat, 2 Apr 2016 02:05:40 +0300
Message-ID: <56FEFEC4.6010401@cogentembedded.com>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com> <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com> <20160401201415.GA25936@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160401201415.GA25936@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 04/01/2016 11:14 PM, Wolfram Sang wrote:
>
>>> IIRC my tests showed that if you don't remove
>>> the spinlocks (patch 4), the interrupt latency will already be too high
>>> again.
>>
>>     Thank you for the valuable info!
>
> Oh, and add patch 6 to it. The context switches are a major problem in
> this.

    Thanks again! I ended up backporting all the patches up to #9. Not sure 
it'd be acceptable for the -stable kernels since there's a lot of refactors 
involved...

MBR, Sergei
