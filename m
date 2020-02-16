From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH] i2c: use kobj_to_dev() API
Date: Sun, 16 Feb 2020 22:46:39 +0100
Message-ID: <d30a1c9a-ad23-1c6a-4195-7a8dd10a9813@lucaceresoli.net>
References: <1581684997-8322-1-git-send-email-qiwuchen55@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:50136 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgBPVqn (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 16 Feb 2020 16:46:43 -0500
In-Reply-To: <1581684997-8322-1-git-send-email-qiwuchen55@gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: qiwuchen55@gmail.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

Hi,

On 14/02/20 13:56, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
