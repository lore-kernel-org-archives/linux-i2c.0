From: Dirk Reske <linux-i2c-fKsByPrBVO2oYr4blSSd5g@public.gmane.org>
Subject: i2c beginner question
Date: Thu, 16 May 2013 23:13:39 +0200
Message-ID: <51954C03.6040808@dirkreske.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hallo,

I have to collect data from multiple external i2c devices.
My question is, what is the correct way?

1: Open i2-device-file, set slave address, read data, close i2c device 
file and go on with the next one
2: keep the i2c device file open all the time, and change slave address 
before every access to device
3: ???

greets
Dirk
