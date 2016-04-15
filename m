From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] i2c: core: Add missing of_node_put()
Date: Fri, 15 Apr 2016 16:34:00 +0100
Message-ID: <571109E8.70005@nvidia.com>
References: <1460724191-12167-1-git-send-email-jonathanh@nvidia.com>
 <5711019E.9020304@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5711019E.9020304@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


On 15/04/16 15:58, Vladimir Zapolskiy wrote:
> On 15.04.2016 15:43, Jon Hunter wrote:
>> for_each_available_child_of_node performs an of_node_get on each
>> iteration, so of_node_put() must be called on each iteration once
>> we are finished with the node pointer.
> 
> This is wrong, embedded of_get_next_available_child() correctly decrements
> ref counter of an examined node.

Oh yes, sorry, I see that now. Sorry for the noise and mis-interpretation here :-(

Jon
