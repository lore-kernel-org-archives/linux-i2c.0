From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: move trivial devices out of i2c subdir
Date: Wed, 1 Feb 2017 07:50:45 -0600
Message-ID: <20170201135045.yass267eakmlpyru@rob-hp-laptop>
References: <20170126225544.5431-1-wsa@the-dreams.de>
 <20170126225544.5431-3-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:32982 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdBANuw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 1 Feb 2017 08:50:52 -0500
Content-Disposition: inline
In-Reply-To: <20170126225544.5431-3-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, Jan 26, 2017 at 11:55:44PM +0100, Wolfram Sang wrote:
> The i2c folder is for i2c bus drivers, not clients. Move the now
> deprecated trivial devices file to the bindings base directory, so it
> can be refactored from there to proper bindings in the relevant
> subdirectories. This will ease maintenance for the I2C subsystem (less
> irrelevant patches automatically CCed by get_maintainer.pl) and it will
> make aware that we deal with the file differently now.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  .../bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt}         | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{i2c/trivial-devices.txt => i2c-trivial-devices.txt} (100%)

Just keep the same name. We can use it for SPI too at least.
