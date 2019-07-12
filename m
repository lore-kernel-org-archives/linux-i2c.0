From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH 4/6] media: i2c: s5c73m3: Convert to new i2c device
 probe()
Date: Fri, 12 Jul 2019 12:27:46 +0200
Message-ID: <4c343c7b-5c43-7234-fae4-4f384c6d09ed@samsung.com>
References: <20190710215149.9208-1-kieran.bingham+renesas@ideasonboard.com>
        <CGME20190710215208epcas2p4a00565b70691c0afb0c3a04f9c43f6cd@epcas2p4.samsung.com>
        <20190710215149.9208-5-kieran.bingham+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710215149.9208-5-kieran.bingham+renesas@ideasonboard.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On 10.07.2019 23:51, Kieran Bingham wrote:
> The I2C core framework provides a simplified probe framework from commit
> b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new() call-back type").
>
> This driver does not utilise the i2c_device_id table in the probe, so we can
> easily convert it to utilise the simplfied i2c driver registration.
>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


Acked-by: Andrzej Hajda <a.hajda@samsung.com>


 --
Regards
Andrzej
