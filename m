Return-Path: <linux-i2c-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CD4EB64D7
	for <linux-i2c@archiver.kernel.org>; Tue, 13 Jun 2023 20:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjFMUvT (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbjFMUvT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Jun 2023 16:51:19 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7831711;
        Tue, 13 Jun 2023 13:51:16 -0700 (PDT)
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
X-GND-Sasl: peter@korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B531FF805;
        Tue, 13 Jun 2023 20:51:13 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.94.2)
        (envelope-from <peter@korsgaard.com>)
        id 1q9Ayu-004oB7-Fu; Tue, 13 Jun 2023 22:51:12 +0200
From:   Peter Korsgaard <peter@korsgaard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i2c: opencores: Add missing type for
 "regstep"
References: <20230613201105.2824399-1-robh@kernel.org>
Date:   Tue, 13 Jun 2023 22:51:12 +0200
In-Reply-To: <20230613201105.2824399-1-robh@kernel.org> (Rob Herring's message
        of "Tue, 13 Jun 2023 14:11:04 -0600")
Message-ID: <871qifw0fz.fsf@48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

>>>>> "Rob" == Rob Herring <robh@kernel.org> writes:

 > "regstep" may be deprecated, but it still needs a type.
 > Signed-off-by: Rob Herring <robh@kernel.org>
 > ---
 >  Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml | 1 +
 >  1 file changed, 1 insertion(+)

 > diff --git a/Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml b/Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml
 > index 85d9efb743ee..d9ef86729011 100644
 > --- a/Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml
 > +++ b/Documentation/devicetree/bindings/i2c/opencores,i2c-ocores.yaml
 > @@ -60,6 +60,7 @@ properties:
 >      default: 0
 
 >    regstep:
 > +    $ref: /schemas/types.yaml#/definitions/uint32

Reviewed-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
