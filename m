From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c: mux: refer to i2c-mux.txt
Date: Wed, 8 Jun 2016 20:34:30 +0200
Message-ID: <4c48ffe4-7637-009f-4e86-7ed6cb243927@axentia.se>
References: <1465366899-4824-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db3on0144.outbound.protection.outlook.com ([157.55.234.144]:39940
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422889AbcFHSeq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 8 Jun 2016 14:34:46 -0400
In-Reply-To: <1465366899-4824-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi!

On 2016-06-08 08:21, Simon Horman wrote:
> Correct references to i2c-mux.txt which was previously mux.txt.
> 
> Also correct the spelling of relevant.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt | 4 ++--
>  Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt      | 3 ++-
>  Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt           | 6 +++---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pinctrl.txt        | 4 ++--
>  Documentation/devicetree/bindings/i2c/i2c-mux-reg.txt            | 6 +++---
>  5 files changed, 12 insertions(+), 11 deletions(-)
> 

Acked-by: Peter Rosin <peda@axentia.se>

Thanks,
Peter
