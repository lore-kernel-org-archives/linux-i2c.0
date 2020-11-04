Return-Path: <SRS0=rSJr=EK=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85EBC2D0A3
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Nov 2020 19:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 586FE206D9
	for <linux-i2c@archiver.kernel.org>; Wed,  4 Nov 2020 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604516672;
	bh=rTnHSMQ/rb6FPiGapyecCcEsyQY8MiIDUG0mjLzm7XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qV1/HhFYi8Z2oceq0+YAh+AnLDdpuHYTyJMqRN1Tg1VGRJomrkKm3uEfeq/DUWey6
	 Q9nSytJ/TZuvCoI0B9AlgaN3HqbrwPAzgikQg1EmkJTd7eXex8Lj0EZ8NPrNUJVtpg
	 9ZIpfMzGtOi65iKJBx7KiqhRI/oERO/59+8lDbmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgKDTEb (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:04:31 -0500
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40609 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgKDTE3 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Nov 2020 14:04:29 -0500
Received: by mail-oo1-f65.google.com with SMTP id l4so774734oos.7;
        Wed, 04 Nov 2020 11:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5dRPFND0K2e5sNRr5+mH4krYgXO4tn5ll5Q7mwx1j8=;
        b=Eqc0MdEpqmfBCe6eMBqjLRYMLE3rhfTS7LtHrg2Thp2NtN7ORk/kGB7gBxF/vXHwV6
         IiCDPR0/s7NYZUEaQzrmz3ATtd//RCaHZiO7IeqysbXvEKgdbfhcrSNk6NpXUgsYpaZr
         Hst2nhcdm3yNWALGHcmUHwwW5MubTKGvl+crBV5x0K5llVep0gR7a19Yw7covgghQxDE
         OD+wWPBBWfU8z4QdQOaMYWMSFT1m4Jo+uNIHXL/CW0NzrQnpvuQ5dG444S52tIl64dOZ
         uifFatasLHuOgqY2+B3dtg59L9iAS2tzE37KW4d0gEBZ+c+6taMNw558U1R9KElFHPD1
         +khA==
X-Gm-Message-State: AOAM531j+GHXZQwQ7KPwAxLMZlIWzLhRyYHLHAb0lbOAEe6Z4cqOIPiC
        Gb+koQfVBxxH/ho6QLLCFw==
X-Google-Smtp-Source: ABdhPJyttCsDRX0g2uzIxU9zqQA01J10xnmgaJZjhmz+FeJAJlbhkM0gPNQjRUd01bMYcZuI614sow==
X-Received: by 2002:a4a:821a:: with SMTP id d26mr3377111oog.90.1604516668960;
        Wed, 04 Nov 2020 11:04:28 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j10sm708982oou.4.2020.11.04.11.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:04:28 -0800 (PST)
Received: (nullmailer pid 3957654 invoked by uid 1000);
        Wed, 04 Nov 2020 19:04:27 -0000
Date:   Wed, 4 Nov 2020 13:04:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Khalil Blaiech <kblaiech@nvidia.com>
Cc:     wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH i2c-next v2 6/6] dt-bindings: i2c: Convert DT file to
 YAML schema
Message-ID: <20201104190427.GA3957380@bogus>
References: <cover.1604432921.git.kblaiech@nvidia.com>
 <c81a0679413dd77e68bdf7e3023d1a54e62f26ea.1604432921.git.kblaiech@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c81a0679413dd77e68bdf7e3023d1a54e62f26ea.1604432921.git.kblaiech@nvidia.com>
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

On Tue, 03 Nov 2020 14:56:08 -0500, Khalil Blaiech wrote:
> Write the devicetree binding text file associated with
> the Mellanox BlueField I2C controller in schema file,
> JSON compatible subset of YAML. Besides, add an entry
> within MAINTAINERS file.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Khalil Blaiech <kblaiech@nvidia.com>
> ---
>  .../devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt | 42 ------------
>  .../bindings/i2c/mellanox,i2c-mlxbf.yaml           | 80 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  3 files changed, 81 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml: More than one condition true in oneOf schema:
	{'oneOf': [{'required': ['unevaluatedProperties']},
	           {'required': ['additionalProperties']}]}
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/i2c/mellanox,i2c-mlxbf.yaml


See https://patchwork.ozlabs.org/patch/1393383

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

