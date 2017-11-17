From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: eeprom: Add Renesas R1EX24128
Date: Fri, 17 Nov 2017 14:30:51 -0600
Message-ID: <20171117203051.ljd5ch3ugmxszmu3@rob-hp-laptop>
References: <1510839994-12473-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36162 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761058AbdKQUax (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 17 Nov 2017 15:30:53 -0500
Content-Disposition: inline
In-Reply-To: <1510839994-12473-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Rutland <mark.rutland@arm.com>, Wolfram Sang <wsa@the-dreams.de>, Bartosz Golaszewski <brgl@bgdev.pl>, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Thu, Nov 16, 2017 at 02:46:34PM +0100, Geert Uytterhoeven wrote:
> Document the compatible value for the Renesas R1EX24128ASAS0A two-wire
> serial interface EEPROM, so it can be used in DTS files without causing
> checkpatch warnings.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
