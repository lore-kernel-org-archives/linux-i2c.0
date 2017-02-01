From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: deprecate trivial-devices.txt for i2c
Date: Wed, 1 Feb 2017 07:48:52 -0600
Message-ID: <20170201134852.o5qbd73plz6ds66j@rob-hp-laptop>
References: <20170126225544.5431-1-wsa@the-dreams.de>
 <20170126225544.5431-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36651 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdBANs7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 1 Feb 2017 08:48:59 -0500
Content-Disposition: inline
In-Reply-To: <20170126225544.5431-2-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org

On Thu, Jan 26, 2017 at 11:55:43PM +0100, Wolfram Sang wrote:
> The idea to collect trivial devices in a seperate file is coming from
> the early DT days and turned out to be a bad decision. It regularly
> creates maintenance pain and the information is not where users would
> expect it (i2c folder is for i2c bus drivers not clients). Also, we do
> not maintain such a file for other subsystems, so we should put an end
> to this as well. First step is to deprecate it and mention that it
> should be refactored into proper bindings.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Actually, I prefer to keep it. Move it up a level and I will take 
patches for it.

Rob
