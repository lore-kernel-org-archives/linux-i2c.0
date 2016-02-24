From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH] i2c: core: add devm apis for i2c_new_dummy and i2c_unregister
Date: Wed, 24 Feb 2016 16:41:14 +0530
Message-ID: <56CD8FD2.6080600@nvidia.com>
References: <1454938058-28457-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454938058-28457-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Monday 08 February 2016 06:57 PM, Laxman Dewangan wrote:
> Add device managed APIs for i2c_new_dummy() and
> i2c_unregister_device() so that it can be managed by
> device framework for freeing it.
>
> This helps on following:
> 1. Maintaining the resource allocation and deallocation
> 	i2c_dummy = i2c_new_dummy();
> 	devm_regmap_init_i2c(i2c_dummy, &regmap_config)
>
> 	On this case, the user of i2c_dummy which is
> 	devm_regmap_init_i2c() is managed allocation where
> 	i2c_new_dummy() is not.
> 	On Free path, we have
> 		i2c_unregister_device(i2c_dummy)
> 	and later, device framework release the regmap. In this
> 	case, client of i2c_dummy after the i2c_dummy.
>
> 	By using devm apis, the sequence can be maintain
> 		i2c_dummy = devm_i2c_new_dummy();
> 		devm_regmap_init_i2c(i2c_dummy, &regmap_config)
>
> 	and resource deallocation will be done in reverse order
> 	by device framework.
>
> 2. No need to release the i2c_client in error/remove path and hence
>     there is less code requirement.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>


Can you please review this?
