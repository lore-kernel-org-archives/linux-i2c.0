From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Date: Sun, 3 Apr 2016 16:35:44 +0300
Message-ID: <57011C30.7020805@cogentembedded.com>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com> <20160331224838.GA7381@katana>
 <56FED245.4010503@cogentembedded.com> <20160401201415.GA25936@katana>
 <56FEFEC4.6010401@cogentembedded.com> <20160402072726.GA1384@katana>
 <56FFC06F.70108@cogentembedded.com> <20160403082513.GA1404@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160403082513.GA1404@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 04/03/2016 11:25 AM, Wolfram Sang wrote:

>>     And I still don't feel good about the patch removing the spinlock -- I'm
>> not sure it's SMP-safe...
>
> In what scenario?

    I've reviewed the patches once again and it looked like they are safe.

MBR, Sergei
