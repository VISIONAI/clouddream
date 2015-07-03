# Dockerized deepdream: Generate ConvNet Art in the Cloud

Google recently released the
[deepdream](https://github.com/google/deepdream) software package for generating images like

![ConvNet Art](http://1.bp.blogspot.com/-CdUrPm7x5Ig/VZQIGjJzP0I/AAAAAAAAAnI/qhqchfzdaOc/s640/image00.jpg)

which uses the [Caffe](http://caffe.berkeleyvision.org/) Deep Learning
Library and a cool iPython notebook example.

Setting up Caffe, Python, and all of the required dependencies is not
trivial if you haven't done it before! More importantly, a GPU isn't
required if you're willing to wait a couple of seconds for the images
to be generated.

Let's make it brain-dead simple to launch your very own
deepdreaming server (in the cloud, on an Ubuntu machine, Mac via
Docker, and maybe even Windows if you try out Kitematic by Docker)!

### Motivation

I decided to create a self-contained Caffe+GoogLeNet+Deepdream Docker image
which has everything you need to generate your own deepdream art. In
order to make the Docker image very portable, it uses the CPU version
of Caffe and comes bundled with the GoogLeNet model.

The compilation procedure was done on Docker Hub and for advanced
users, the final image can be pulled down via:

```
docker pull visionai/clouddream
```

The docker image is 2.5GB, but it contains a precompiled version of
Caffe, all of the python dependencies, as well as the pretrained
GoogLeNet model.

For those of you who are new to Docker, I hope you will pick up some
valuable engineering skills and tips along the way. Docker makes it very easy
to bundle complex software. If you're somebody like me who likes a
clean Mac OS X on a personal laptop, and do the heavy-lifting in the
cloud, then read on.

# Instructions for use

We will be monitoring the `inputs` directory for source images and
dumping results into the `outputs` directory.  Nginx (also inside a
Docker container) will be used to serve the resulting files and a
simple AngularJS GUI to render the images in a webpage.

Prerequisite:

You've launched a Cloud instance using a VPS provider like
DigitalOcean and this instance has Docker running. If you don't know
about DigitalOcean, then you should give them a try.  You can lauch a
Docker-ready cloud instance in a few minutes.  If you're going to set
up a new DigitalOcean account, consider using my referral link:
[https://www.digitalocean.com/?refcode=64f90f652091](https://www.digitalocean.com/?refcode=64f90f652091).

Let's say our cloud instance is at the address 1.2.3.4 and we set it
up so that it contains our SSH key for passwordless log-in.

```
ssh root@1.2.3.4
git clone https://github.com/VISIONAI/clouddream.git
cd clouddream
./start.sh
```

Then from your local machine you can just scp images into the `inputs`
directory inside deepdream as follows:

```
#From your local machine
scp "images/*jpg" root@1.2.3.4:~/clouddream/deepdream/inputs/
```

You should now be able to visit `http://1.2.3.4` in your browser and
see the resulting images appear in a nicely formatted mobile-ready grid.

You can also show only `N` images by changing to the URL so something like this:
```
http://1.2.3.4/#/?N=20
```

And instead of showing random `N` images, you can view the latest images:
```
http://1.2.3.4/#/?latest
```

Here is a screenshot of what things should look like when using the 'conv2/3x3' setting:
![deepdreaming Dali](https://raw.githubusercontent.com/VISIONAI/clouddream/master/deepdream_vision_ai_screenshot.png)

And if you instead use the 'inception_4c/output' setting:
![deepdreaming Dali](https://raw.githubusercontent.com/VISIONAI/clouddream/master/deepdream_vision_ai_screenshot2.png)

Additionally, you can browse some more cool images on the
[deepdream.vision.ai](http://deepdream.vision.ai) server, which I've
currently configured to run deepdream through some Dali art. When you
go to the page, just hit refresh to see more goodies.

### Changing the default parameters
Inside deepdream.py you'll notice that I'm using

```python
frame = deepdream(net, img, end='conv2/3x3')
```

But you can try different layers such as:

```python
frame = deepdream(net, img, end='inception_3b/5x5_reduce')
```

### The GUI

The final GUI is based on https://github.com/akoenig/angular-deckgrid.

### Credits

The included Dockerfile is an extended version of
https://github.com/taras-sereda/docker_ubuntu_caffe

Which is a modification from the original Caffe CPU master Dockerfile tleyden:
https://github.com/tleyden/docker/tree/master/caffe/cpu/master

This dockerfile uses the deepdream code from:
https://github.com/google/deepdream

### License

MIT License. Have fun. Never stop learning.

--Enjoy!
The vision.ai team


