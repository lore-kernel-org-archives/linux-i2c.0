From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 3/3] i2c: mux: pca9541: prepare for PCA9641 support
Date: Wed, 21 Mar 2018 09:05:09 +0200
Message-ID: <7c14645a-3166-c793-550f-0db8cdfd8873@mleia.com>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
 <20180320093200.19179-4-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320093200.19179-4-peda@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 03/20/2018 11:32 AM, Peter Rosin wrote:
> Make the arbitrate and release_bus implementation chip specific.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>


The change is really good and correct, it is just too extended IMHO.

--
With best wishes,
Vladimir
