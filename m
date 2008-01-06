From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/7] i2c : convert semaphore to mutex in struct class
Date: Sun, 6 Jan 2008 16:56:52 +0100
Message-ID: <20080106165652.563b6423@hyperion.delvare>
References: <20080103055441.GC4885@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758500AbYAFP5N@vger.kernel.org>
In-Reply-To: <20080103055441.GC4885@darkstar.te-china.tietoenator.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Young <hidave.darkstar@gmail.com>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 3 Jan 2008 13:54:41 +0800, Dave Young wrote:
> Use mutex instead of semaphore in struct class.
> 
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 
> ---
> drivers/i2c/i2c-core.c |    9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
