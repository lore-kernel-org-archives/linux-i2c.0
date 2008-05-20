From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [patch 0/2] i2c-core.c: use list_for_each_entry_safe()
Date: Tue, 20 May 2008 22:07:44 +0200
Message-ID: <20080520220744.3433cf81@hyperion.delvare>
References: <20080519204838.612046856@kaehlcke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932640AbYETUIU@vger.kernel.org>
In-Reply-To: <20080519204838.612046856@kaehlcke.net>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias@kaehlcke.net
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 19 May 2008 22:48:38 +0200, matthias@kaehlcke.net wrote:
> i2c-core.c: use list_for_each_entry_safe() in i2c_del_adapter() and i2c_del_driver()

Applied, thanks.

-- 
Jean Delvare
