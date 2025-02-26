% 生成数据集
input = twomoon_gen(200, 200, 0.12, 0.04, -0.04);

% 分离数据集为两个类别
num1 = 200;
num2 = 200;
data_class1 = input(1:num1, :);
data_class2 = input(num1+1:num1+num2, :);

% 绘制图像
figure;
scatter(data_class1(:, 1), data_class1(:, 2), 'r', 'filled');  % 类别1用红色表示
hold on;
scatter(data_class2(:, 1), data_class2(:, 2), 'b', 'filled');  % 类别2用蓝色表示
xlabel('X');
ylabel('Y');
title('Two Moon Dataset');
legend('Class 1', 'Class 2');
hold off;
