From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: i2c_new_{secondary_device,dummy,device}() return type.
Date: Fri, 09 Feb 2018 14:26:36 +0200
Message-ID: <9433176.auEORrE3aR@avalon>
References: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <6f03d1e1-b542-99cb-7cfe-8eae9addd8d9@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:MEDIA DRIVERS FOR RENESAS - FCP" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kieran,

On Friday, 9 February 2018 12:01:09 EET Kieran Bingham wrote:
> Hi Wolfram,
> 
> As part of my work looking at using i2c_new_secondary_device() to move
> address mappings into the device tree, it has become evident that the
> return code of the i2c_new_secondary_device() is obfuscated, and is simply
> a valid client - or NULL.
> 
> This means that we must 'guess' as to whether the device failed due to a
> memory allocation, or if the device address was already in use (perhaps a
> more common failure).
> 
> Because of this - I would like to see the return codes of
> i2c_new_secondary_device(), ic2_new_dummy(), and therefore i2c_new_device()
> support returning ERR_PTR()s rather than a client or NULL.
> 
> These functions are used fairly extensively - thus it will be a fair bit of
> work (or a good coccinelle script) - So I'd like to ask your opinion on the
> validity of this task before I commence anything down that rabbit hole!
> 
> Any comments? Pre-ack/nack? (from anyone?)

Pre-ack from me :-)

-- 
Regards,

Laurent Pinchart
