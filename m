Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C77D26E
	for <linux-i2c@vger.kernel.org>; Sun, 26 Nov 2023 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Caor826w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE997C433C7;
	Sun, 26 Nov 2023 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701008574;
	bh=BNgeLRJLCAh0rW9IkfVXu7f7qPYQfsEuFY1bt7Md1nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Caor826w4BjAII1NYrBsv+w1kcRWAfbeXDKWIM0TQZdZxpuxOrZfNF76V/fNHSPJo
	 nEwm4WzeoC/GPPzaj54RpB8+6+Qe55NjxQGQqt0+NRJrQjbe+gDcqdu5YnKdbppnHQ
	 st7neXsE3C09N20vbiYyNL9TBxFMzUSl4VNIdYUi6B05jt6T3tylxyFDpsfPrNs00P
	 rq1t0WCk/Qs5skZNaGOxIFja+PNOb7LhgGfNOXvSY3k19KySZ9IZlgkRGA50vkLVlx
	 ohsgdHR7P+9BS6bCSzttd36bYb7Z56YfLPz5sO/V7SMDa+hGlVBK06zs2A3fsgNgv1
	 RFc3J6bkEuoWg==
Date: Sun, 26 Nov 2023 15:22:50 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
	linux-i2c@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] i2c: pasemi: Don't let i2c adapters declare
 I2C_CLASS_SPD support if they support I2C_CLASS_HWMON
Message-ID: <20231126142250.afzfqb5obrvkglsl@zenone.zhora.eu>
References: <20231124101619.6470-1-hkallweit1@gmail.com>
 <20231124101619.6470-4-hkallweit1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124101619.6470-4-hkallweit1@gmail.com>

Hi Heiner,

On Fri, Nov 24, 2023 at 11:16:12AM +0100, Heiner Kallweit wrote:
> After removal of the legacy eeprom driver the only remaining I2C
> client device driver supporting I2C_CLASS_SPD is jc42. Because this
> driver also supports I2C_CLASS_HWMON, adapters don't have to
> declare support for I2C_CLASS_SPD if they support I2C_CLASS_HWMON.
> It's one step towards getting rid of I2C_CLASS_SPD mid-term.
> 
> Series was created supported by Coccinelle and its splitpatch.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
