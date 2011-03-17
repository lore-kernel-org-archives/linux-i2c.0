From: <Waldemar.Rymarkiewicz@tieto.com>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Thu, 17 Mar 2011 14:58:38 +0200
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AB119@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101452.54862.arnd@arndb.de>
 <99B09243E1A5DA4898CDD8B7001114481082EF2A65@EXMB04.eu.tieto.com>
 <201103101720.53782.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201103101720.53782.arnd@arndb.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Arnd,

>> >Note that the microread_is_busy() logic does not protect you from 
>> >having multiple concurrent readers, because multiple threads may 
>> >share a single file descriptor.
>> 
>> It's just used to ensure that only one reader can open the device.
>> It's called only in open callback.
>> The mutex actually secures concurrent read operations. 
>
>So if having multiple readers is safe (though possibly not 
>meaningful), I guess you don't really need the 
>microread_is_busy() logic.
>
>I suppose it doesn't hurt either, it just seems a bit 
>pointless when it does the right thing most of the time, but 
>not always.
>

Could you give me an example when the microread_is_busy() logic does not do what it's intended to do.
I don't really get your point here. 


Waldek
