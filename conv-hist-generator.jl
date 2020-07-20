using DSP, Plots



#---------------------------------------------------------#

for LENGTH=3:5
    for i = 1:10
        x = rand((-1,0,1), LENGTH)
        h = rand((-1,0,1), LENGTH)
        y = conv(x, h)

        p1 = plot(1:LENGTH, x,
                    seriestype=:bar,
                    title="x[n]",
                    linealpha=0,
                    color=:blue,
                    alpha=0.7,
                    legend=:none,
                    showaxis=true,
                    ylims=(-1,1))

        p2 = plot(1:LENGTH, h,
                    seriestype=:bar,
                    title="h[n]",
                    linealpha=0,
                    color=:grey,
                    alpha=0.7,
                    legend=:none,
                    showaxis=true,
                    ylims=(-1,1))

        p3 = plot(1:LENGTH*2-1,
                    y,
                    seriestype=:bar,
                    linealpha=0,
                    alpha=0.7,
                    color=:red,
                    title="y[n] = x[n] * h[n] = h[n] * x[n]",
                    ylims=(-5,5),
                    showaxis=true,
                    minorgrid=true,
                    legend=:none)
        plot!(1:LENGTH*2-1,
                    [x;zeros(LENGTH-1)],
                    seriestype=:bar,
                    linealpha=0,
                    alpha=0.2,
                    color=:blue)
        plot!(1:LENGTH*2-1,
                    [h;zeros(LENGTH-1)],
                    seriestype=:bar,
                    linealpha=0,
                    alpha=0.1,
                    color=:grey)


        question_layout = @layout[a;b]

        if (!isdir("images"))
            mkdir("images")
        end

        plot(p1, p2, layout = question_layout, title="Convolve these two series.")
        png("images/$(LENGTH)_$(i)_side-a_question")

        plot(p3, title="Convolution in red! Did you get it?")
        png("images/$(LENGTH)_$(i)_side-b_answer")
    end
end
