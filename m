From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC 7/9] ARM: shmobile: r8a7791: dtsi: add internal delay for
 i2c IPs
Date: Fri, 27 Nov 2015 14:58:38 +0300
Message-ID: <5658456E.60509@cogentembedded.com>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
 <1448578757-12613-8-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34597 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbbK0L6l (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Nov 2015 06:58:41 -0500
Received: by lffu14 with SMTP id u14so127316024lff.1
        for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2015 03:58:40 -0800 (PST)
In-Reply-To: <1448578757-12613-8-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hello.

On 11/27/2015 1:59 AM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index d79102c0e7d346..57b806f8c28fad 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -408,6 +408,7 @@
>   		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
>   		power-domains = <&cpg_clocks>;
>   		status = "disabled";
> +		i2c-scl-internal-delay-ns = <6>;

    I suggest that you add the new props before "status".

MBR, Sergei
